# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5a08b8fe234fd7c5b0edb8aa215cae3d363f33551e68caaf941b625069e5edfa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "74a3e49bef7fbee33976c3b49ea4550224a90c4571c8e654d6d7352fb030b135"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9c1dfc207c25b37facbe41faa6b08fd0ac75bfbbdbcc3d0980811ba8e02b2dd2"
    sha256 cellar: :any_skip_relocation, ventura:       "d2ddb430afaa3f660686f6bcfcbc93d192aee3b91fb5a125c446a0040bf621f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7de4b3306d7403a70c4e31830b3a4b3f6ee9e50618264fa5bd8abfd1936dfce0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e23428366645ed163564a92ee3d9b6f901e0ca6e084769ba264672e89bba3b15"
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
