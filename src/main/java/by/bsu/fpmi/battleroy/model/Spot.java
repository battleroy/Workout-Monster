package by.bsu.fpmi.battleroy.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "SPOT", uniqueConstraints = @UniqueConstraint(columnNames = {"SPOT_LATITUDE", "SPOT_LONGITUDE"}))
public class Spot implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "SPOT_ID")
    private long id;

    @Column(name = "SPOT_NAME", nullable = false)
    private String name;

    @Column(name = "SPOT_ADDRESS", nullable = true)
    private String address;

    @Column(name = "SPOT_LATITUDE", nullable = false)
    private double latitude;

    @Column(name = "SPOT_LONGITUDE", nullable = false)
    private double longitude;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FK_USER_ID", nullable = false)
    private User creator;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

}
