# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db32a1f8f634404e8c4eb9b45b4ffe67c420375621b115dce09ad81c799ba734"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5824e7556f9fede9c34c330225bb7639b47f3190a3bf3409041e6cb0cb417b3d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c6011a7c2298e300244aecb51d4271a500cf0c70cf7103d96821d3eadec4103e"
    sha256 cellar: :any_skip_relocation, ventura:       "9ba175c41c445a3d12034611db31e96b9a4ec8c565c68e9575b9dc4b8e10b467"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5e6cc132d9b66c69b3ec3f01e12de4f22137a4d59683289e5cfa013e6bf9a596"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6de7ea96776c7e06d4b546859445d6e49491024235add068e422d059e849b53b"
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
