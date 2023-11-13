# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "89d9df88af866235237efcf05b64079c91f51ffacc2ea28a80256df6d78a8328"
    sha256 cellar: :any,                 arm64_monterey: "266790a2100245842eb12d0a114eb3abee69b15be6cef749e5bdfbf7430f1550"
    sha256 cellar: :any,                 arm64_big_sur:  "aa82cb203a20fe0c5795a0ec8f641d87191f10559afde3183b43f18f809291f5"
    sha256 cellar: :any,                 ventura:        "110acb47301dfdbba2b57afd8228b6a42c8d7ea2ff36be196cfd37459eab4366"
    sha256 cellar: :any,                 monterey:       "6dc847621d8974b600950073dfc0632a7dd366aeb556771baab9ed743a8d26ee"
    sha256 cellar: :any,                 big_sur:        "edc6c1176435f74a45decf993355e925d68538f9a2227ac21f2f2bbeebe3436e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bf8326fadb2006acb1ffc6bbd937a82ebd2010443c53a5b9f47e98a942e0dd6"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
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
