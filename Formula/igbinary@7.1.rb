# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.2.tar.gz"
  sha256 "3f8927d5578ae5536b966ff3dcedaecf5e8b87a8f33f7fe3a78a0a6da30f4005"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2c5239c025dbe8bc9b5297d795d860fecae3a8dc0c10ef4bf6a2a63ed1d4998d"
    sha256 cellar: :any_skip_relocation, big_sur:       "b21b25baf846b3a89d02003c0b0dab17bd366b54bb3f0cdf1c4ef4eb1cd61362"
    sha256 cellar: :any_skip_relocation, catalina:      "75f333dd3d8bce2ec1aa820d83dc30ef898f07885099ff5b61fa8872dc8c75e9"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
