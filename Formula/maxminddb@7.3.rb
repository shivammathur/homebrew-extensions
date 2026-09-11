# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT73 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "800cdb8fee92300adbe35a93334b42a8b4ab558aba559e40480fbba1679b7759"
    sha256 cellar: :any, arm64_sequoia: "4d188c711068eae43483528325c4590c916c53bf4d578c108bdc007110b66d96"
    sha256 cellar: :any, arm64_sonoma:  "5ffceac14308df7335f4ad0a4801c4930d1dfd7ef01c62a94c3dd37265941bfe"
    sha256 cellar: :any, arm64_linux:   "1b06028b023ef2c823c73f03fc6000c4709d5dff1ab13d151eafbb4c67c95e82"
    sha256 cellar: :any, x86_64_linux:  "686c5f329fc6b30f81631e5ae4fefbfff90c1e246be7e3bce4f3538d86178fee"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
