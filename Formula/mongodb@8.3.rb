# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f9baaf1c0e51f04322779223540f8959e0204aa284c3e3ca9a8e28a29c9cb555"
    sha256 cellar: :any,                 arm64_ventura:  "7fd6f65fc86a17ad38db4ce6c3fb3086bfa18ed49f5c2996a3f22f932305b365"
    sha256 cellar: :any,                 arm64_monterey: "1ca1f0e132370e789cad38bc82cb7458e3489ab6cb39fd3f96b924446c75ef71"
    sha256 cellar: :any,                 ventura:        "44bbaafe60bc7f3f1dc62ef021f0c7b12cba4e8765506930fd0e5f1e80226df9"
    sha256 cellar: :any,                 monterey:       "daad9929118a85fa0d448decd4c73273994fbed3a5100746fd08d49b381f1211"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efa308e9db251cfe09b94a121bb5a0bbbcb9ea37850ff6adc20a33250c2fc8c2"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
