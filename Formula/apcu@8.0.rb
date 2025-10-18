# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8a3c35fb821a90f061029d4692f115d9be655129e5d42c12efb5ee85fdca3cf1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4dd36a65d7fca2bf7871af4915079eb116de3ffb3d141831e285c0afe1455bbf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "18f2ee91051c9be9b5e4c9f86f60728058e3ff18c68490da8e300e222dc62012"
    sha256 cellar: :any_skip_relocation, sonoma:        "5961d4fc7c0417609bf022cb0439ffb9ef41c105bf7be2f9dfad5236155cf8af"
    sha256 cellar: :any_skip_relocation, ventura:       "6d8927fe50e4c28878e40eeb5c97b1916904b75900583505eebaefc25fb4122c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f6b66d8354f9a4b8c1d6f98790e9f1dc1050aaa0614337de405da4454bda48f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19bc49ba88088ae11e305935a16be01f827ff9ad691eebfbea07892d899d2f9c"
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
