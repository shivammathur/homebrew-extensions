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
    rebuild 40
    sha256 cellar: :any,                 arm64_sequoia: "84486175ca3a9e3958a1be812f93f5d743fc87463c752cf47f21cc870387f7db"
    sha256 cellar: :any,                 arm64_sonoma:  "6838fc4bcae9d35c14c1c7640776bc21b27b4339646a2f4196fbbfd10498a87f"
    sha256 cellar: :any,                 arm64_ventura: "9d64371a42e34f8a538a552116b110f3dabdc009b12a5d599a073360c4b0bd93"
    sha256 cellar: :any,                 ventura:       "60e8e83f8b6fe7c1ba8a4052f5334f0e12a25770c6164e31cabb0706349b06a7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9601671bea479063c1f47dda19e770746d5bc9e407dd620ac6ed4fc63d1b5b0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a538aeeb890e1ea897ce6cd0ecf24e145b32e6730ded25dfeb70d7fb60dbec99"
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
