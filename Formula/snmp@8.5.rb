# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0bf295944df7171acf47502d31dd7df8b9155d81.tar.gz?commit=0bf295944df7171acf47502d31dd7df8b9155d81"
  version "8.5.0"
  sha256 "07ee46fa596dca898e187676aafd2b9d781dbb7a67fc98aace6b9d35de36f7a9"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 39
    sha256 cellar: :any,                 arm64_sequoia: "5a1c40615eed1478747e0834e2bdcb033876e4bc712ed5737d903026e8a15ed8"
    sha256 cellar: :any,                 arm64_sonoma:  "528831ef28163eb4abc5dd49187185a089fc892ef8f8640ea33c8e1d34d199ae"
    sha256 cellar: :any,                 arm64_ventura: "3051bd0aaf4e9b627154b1c5f5beedebe2866b62bb0264203b3d6a760065e822"
    sha256 cellar: :any,                 ventura:       "d5570b388f1b5085e5fd24fa7097af0a754ae9f6dc651b88001439b15f69f61f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "27b7a9a314e132ee482d59fe26ae052a2476f48c6bc7db14cbac4b2b6f52eaaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e19d3f2a54cb368a4c37975f8f2376d0aa0fbe99cd269de142a3325e369cc10c"
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
