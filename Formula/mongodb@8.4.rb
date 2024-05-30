# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "748802e8e13cb03eb063c67dec21ddbcac48c497dc0e69f7b6e840f5131ad11d"
    sha256 cellar: :any,                 arm64_ventura:  "f58b11a1c0a9b6468dc27ba3069530ad46a7be802dc951792f2bf464766c941f"
    sha256 cellar: :any,                 arm64_monterey: "104d04160c7d98080a2024ab2ba94dd157bb6298af9f3ab2138af6389704f49b"
    sha256 cellar: :any,                 ventura:        "9f79f6713ab906ecde15ce632bb722a70ceae0e4790ab921a17fe689a2fa3950"
    sha256 cellar: :any,                 monterey:       "a590bcf1b717040c190958f72c2f43475f95b9fd66f69d031eaa27c7e712183a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "028d584a6c36267b1726a9b045ec5b6fd811517e3567e1eb250ede74e610e43d"
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
