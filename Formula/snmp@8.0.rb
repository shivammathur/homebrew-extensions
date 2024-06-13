# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b9fa9ad2990f1fac1c7b726d8c9f8b58f1c2ac69.tar.gz"
  sha256 "2265e11a442da6acdd6dfe9ffb78883a9058ea5a2a05f7a264d6188a0a2c4d1f"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "965715852b7bcac914c6b1b46cc44fa9bbc4ca70e4df3d063f5a90904c2981d2"
    sha256 cellar: :any,                 arm64_ventura:  "a9840adcf1e79595f622339a2f0108bb9a586d61f504d85a635b3dbf39ac68ee"
    sha256 cellar: :any,                 arm64_monterey: "e979cc6602c99093c80992ab9d2a7fa76ec2a2ab4357256afdb11273967154ef"
    sha256 cellar: :any,                 ventura:        "497743693d6cea15e83aefa84e53566488ebc63cce2a033850dbb95c2b721744"
    sha256 cellar: :any,                 monterey:       "db8a78c11cf1d5600aea3f3a3daf4afaf2e64d3a260879fe25b96de8af592492"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a4927f54eb1cd417a5991a63cc654c6f9e2c9cb02cd0b70a17cb8dac1e0513f0"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
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
