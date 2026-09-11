# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "7d4c73dfab2309428e93e8c4de9aee4e9689e0624cbe48b7363ee3f2f95955a2"
    sha256 cellar: :any, arm64_sequoia: "f41f427cfeb40a123c90de10f6021945c79bd980df73a18e9504794e617714d3"
    sha256 cellar: :any, arm64_sonoma:  "1e0bce6acb5cb90e97f4955b460b9cd012ad8df6e025a09fe029e31112745100"
    sha256 cellar: :any, arm64_linux:   "17ced28116821c4b0566ba468e5037f7347c40731f872602bc9035f9521ee4e3"
    sha256 cellar: :any, x86_64_linux:  "4f608be0673d054afd105cf048ee323940742c79e22a202f70d524438b87d215"
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
