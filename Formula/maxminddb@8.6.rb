# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  revision 1
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c3af6fc121f1bcb5eb6b4aca1df050ade5309cc81cd6bcf1791ef6b0cef51a14"
    sha256 cellar: :any, arm64_tahoe:       "6b742aa77b0afc83718a854193a09a31b1039ee5278ef0446812ca88198dfebc"
    sha256 cellar: :any, arm64_sequoia:     "aa81703c5a941172c3546fab96559babddf40a9eb071d6c6605a03ba2712fa44"
    sha256 cellar: :any, arm64_linux:       "2906839f3f812b7fced945562f1899bb8cb2d3b2e5a13c2d22e52c72118df5c6"
    sha256 cellar: :any, x86_64_linux:      "780483157a37665276cf1286d133c150e6f087c77bc14f6c97c99f2e33d20bb6"
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
