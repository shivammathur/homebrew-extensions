# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.0.tgz"
  sha256 "17bffaa656bd51225dc4da2380d5aefbf2de03ea790b5c29841839c1f002b894"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "1b2266856887630af20f090cf237c4be23412e356c9ac03342662f186bc6b341"
    sha256 cellar: :any,                 arm64_ventura:  "85caaba8f4710a4f28fe9a59d0fed7d1343d2ceea9b0a7218332897bcc0efebb"
    sha256 cellar: :any,                 arm64_monterey: "68aa1eb1f553e1d9b4db35837aa3480debd05ad5efb0f2dee4443296a21506cd"
    sha256 cellar: :any,                 ventura:        "3c875d47768c7241d4657cf629de99b0a8112f05c31d6e7391025307630f67e5"
    sha256 cellar: :any,                 monterey:       "6995d3997eae8064afc7acf6ea1f897f8f1f946fe76a0c8610097730af8347fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8c82288d539857ece128ed8e22976ba2256189b576ca4286253763d1144f696"
  end

  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@3"]}.opt_prefix"
    Dir.chdir "couchbase-#{version}"
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
