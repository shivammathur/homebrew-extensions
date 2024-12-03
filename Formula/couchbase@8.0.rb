# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "905092bc4d066e419f8fc5d6caa36854a91283ff26ce26378c4b5b1747f5215b"
    sha256 cellar: :any,                 arm64_sonoma:   "c0aa2388228c848022b1f76e200df64f8859c10337aac16ea673c6218f8e48f2"
    sha256 cellar: :any,                 arm64_ventura:  "1ec9ebfa912af997ef4267359b5ec8553515e392262dc8de14bf526fd1627f93"
    sha256 cellar: :any,                 arm64_monterey: "7bc21bdef00e2195d3730b74a7a6f69cf6b6c5c8cf5d173b740303dcf6e5ee08"
    sha256 cellar: :any,                 ventura:        "f28af6d2226f80ecba999bebd9f6ff838b39756f6ceeb6f4843838c5492d1219"
    sha256 cellar: :any,                 monterey:       "69b99d66bcf7a57f09ae3c19be81fea60bd5c330d93389a155e532b178394f22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b353e63e41262c0c62877fdf87b17474eaae33d4a9bc71aa5a72bc95096d021"
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
