# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/df078fae973c27986c4e8d588871958dafc7a34a.tar.gz"
  version "7.2.34"
  sha256 "90971ad36e57ac243ba2454c28744f3e17bc2282d4dbd2ec9bb96bf8dc103eb1"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "a397f549aaca53bbe982775712cf855d7a3fd438814cb08ab557a001d8b2672d"
    sha256 cellar: :any,                 arm64_sonoma:   "7b975c65f27871180600ed2ff64a5f143b13b7c8ae0c86869c22a489b93b018d"
    sha256 cellar: :any,                 arm64_ventura:  "5eb96c78df9853ff3a39e29b1dfe4b5de8bfa1b4282e68d8d3523021347405db"
    sha256 cellar: :any,                 arm64_monterey: "ed85239f9f9b32732eca7644339b8348d91c677693a5ac13a4707191dac5f078"
    sha256 cellar: :any,                 ventura:        "40a92a81d1143689a88ed6601cc1e0e035fa63a190ae45891726d9eb79fa5705"
    sha256 cellar: :any,                 monterey:       "e52bf1e8c2caf1c808a26aa4bb8c40758c0c20e26ce9e5a249ca698235f5eebd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b26ea96430da5baf082d4ea1e96e8605f37ad18a63dc9126eae83fd3f4d41d9"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
