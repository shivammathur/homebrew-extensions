# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a00bcfe24c6f98c791cf29c0fb4866650ab994c5fee6f172546ebf33361007d8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7a7af758cbc4e910ac1d5bb7209b8edb5e05851764a9e0a969486f7c2a16f475"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "473f62c08cea72874d9a9ca16201fabe5e0fa239f5bd0016594fe8f5138fa482"
    sha256 cellar: :any_skip_relocation, ventura:       "0202b1ec3e6103d3e11af73954b350659e581648b3903ee8f3d25e18fe3961f1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa72097bbbe1e5e8d393d3b03bb37c548cde52eccb62a1f7c77ffd315d2c2acb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df2e2507eaf297ea1382ab0a1c4b703d864ad9da1e5aff762734330079e0a9a8"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
