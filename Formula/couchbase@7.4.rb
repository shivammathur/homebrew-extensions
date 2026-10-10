# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 2
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "d294c4d5c20aa5d4a699bec1066af6b0f0507e0746f347105b3381bbfb21ae0f"
    sha256 arm64_tahoe:       "88bbaeb62e132e057ea21e3dac479bc49ba893f04f1e618269f0f69241416077"
    sha256 arm64_sequoia:     "107704b2ad16b99caa0f70f0abd8308cd0089bf8885260a4fa04ae2072ba0bc7"
    sha256 arm64_linux:       "0fda4d3e7abf6824224abad0ecbaeafd44f5d4c949518472aec74e37be57e6c0"
    sha256 x86_64_linux:      "27b64f1d9814573677d278713ffea94ecc0f56d413fbe83af5a6eb6e214346da"
  end

  depends_on "cmake" => :build
  depends_on "openssl@4"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = Utils::Path.formula_opt_prefix("openssl@4").to_s
    on_macos do
      ENV["CXX"] = "clang++"
      ENV["CXXFLAGS"] = "-std=c++17"
    end
    Dir.chdir "couchbase-#{version}"
    inreplace "src/deps/couchbase-cxx-client/third_party/asio/asio/include/asio/ssl/impl/" \
              "rfc2818_verification.ipp" do |s|
      s.gsub!(/\b(domain|ip_address|common_name)->data\b/, 'ASN1_STRING_get0_data(\1)')
      s.gsub!(/\b(domain|ip_address|common_name)->length\b/, 'ASN1_STRING_length(\1)')
      s.gsub!(/\b(domain|ip_address|common_name)->type\b/, 'ASN1_STRING_type(\1)')
      s.gsub!(/\b(X509_NAME|X509_NAME_ENTRY|ASN1_STRING)\*/, 'const \1*')
    end
    inreplace "config.m4",
              '-DCMAKE_C_COMPILER="${CC}"',
              '-DCMAKE_C_COMPILER="$(CC)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    safe_phpize
    inreplace "configure",
              "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
              "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
