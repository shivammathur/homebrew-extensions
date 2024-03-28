# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d504602ec95e2da6d4cee125019642f4b28b4b80a9f9103e4f02d127f36fd27f"
    sha256 cellar: :any,                 arm64_ventura:  "5906a4ab4b9c1bf4dd029fc1891156d5537f70db5ba58986fd5bd5e416221fce"
    sha256 cellar: :any,                 arm64_monterey: "f0bcbb8c3c9b03a4a768e50fd3a61bd5e78913c1f4f15289eb92a135c1d44a79"
    sha256 cellar: :any,                 ventura:        "88bced424179b7cfc39dfb1a2548cc4015280469d37a0ffec5732872a7ceb431"
    sha256 cellar: :any,                 monterey:       "73e9fa03a548369f42963187ee12d315599165883fe26b53f56e19bbbae85198"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "03f57a3868d9634cf477d59b0bfbdee72c5444cda7e04ce4c375507f683ba611"
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
