package com.carmanagement.entity;

import java.math.BigDecimal;

public class Vehicle {

		String name;
		String brand;
		String model;
		int rental_price_per_hr;
		String availability;
		String fuel_type;
		int admin_id;
		int vehicle_id;
		
		public Vehicle(){	
		}
		
		public Vehicle(String name, String brand, String model, int rental_price_per_hr, String availability, String fuel_type, int admin_id){
			this.name = name;
			this.brand = brand;
			this.model = model;
			this.rental_price_per_hr = rental_price_per_hr;
			this.availability = availability;
			this.fuel_type = fuel_type;
			this.admin_id = admin_id;
		}
		
		// setter methods
		public void setVehicle_id(int vehicle_id) {
			this.vehicle_id = vehicle_id;
		}
		
		public void setName(String name) {
			this.name = name;
		}
		
		public void setAdmin_id(int admin_id) {
			this.admin_id = admin_id;
		}
		
		public void setBrand(String brand) {
			this.brand = brand;
		}
		
		public void setModel(String model) {
			this.model = model;
		}
		
		public void setRental_price_per_hr(int rental_price) {
			this.rental_price_per_hr = rental_price;
		}
		
		public void setAvailability(String availability) {
			this.availability = availability;
		}
		
		public void setFuel_type(String fuel_type) {
			this.fuel_type = fuel_type;
		}
		
		
		// getter methods
		
		public String getName() {
			return this.name;
		}
		
		public String getBrand() {
			return this.brand;
		}
		
		public String getModel() {
			return this.model;
		}
	
		public int getRental_price_per_hr() {
			return this.rental_price_per_hr;
		}
		
		public String getAvailability() {
			return this.availability;
		}
		
		public String getFuel_type() {
			return this.fuel_type;
		}
		
		public int getAdmin_id() {
			return this.admin_id;
		}
		
		public int getVehicle_id() {
			return this.vehicle_id;
		}
	
}
