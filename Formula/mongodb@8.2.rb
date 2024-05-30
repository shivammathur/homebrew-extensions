# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "77b0746e76ac71ec3ab31125768ff98bee52c9a5cd4140fc5638b3b522dc31c7"
    sha256 cellar: :any,                 arm64_ventura:  "8e739a41b34d739dacd2e6049da3c319e0e668604ab85e30f816b56d68a894bb"
    sha256 cellar: :any,                 arm64_monterey: "746d80eded02892d494f324853dcee74b8476b793dd26ebeb7cecf466df0bc53"
    sha256 cellar: :any,                 ventura:        "914699719bc359f39658291a373364fb2486cd69ac57996bbf37562fbcf4aae9"
    sha256 cellar: :any,                 monterey:       "8fd1d1473830d148ea540595386c01adcdf04f35dfbaf4bdd1ae25b2358bd4e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09d2bbb90000f3276545d1622a1be49745fb7af2d80d886b1e079cdd37c23fbc"
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
