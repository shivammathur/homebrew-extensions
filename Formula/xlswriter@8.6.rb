# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.3.tgz"
  sha256 "b69c168780527ec73fa3d7986d4279ecce00e184760f6572cc5e450a68b4f201"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c5e7b2ca79c5da0a7117ee6c5e7927656b2f93c5251d3d978374d65cad213028"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "91f0b9c6325a4ca5b3b9b9a25386c3ebb8167205c047dd7cf52d594dd203fca2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b214610c1757bc151e6e7af8b417a816ae6f16f6df5d968a01c3ab22649583f"
    sha256 cellar: :any_skip_relocation, sonoma:        "affcaee5f71cbff1db3b6be327de35888ea24c737af0e0c00ac263db63918820"
    sha256 cellar: :any,                 arm64_linux:   "eeda1cd35fc728c74ed025849ea5ae37d0d468e6fc7468e7ece373d2b2f5d3fd"
    sha256 cellar: :any,                 x86_64_linux:  "91b77e40f64330534f2031dea4a560fe2e34d6c1519b1a488fa33b655daa1a8a"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    ENV.append "CFLAGS", "-std=gnu17"
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
