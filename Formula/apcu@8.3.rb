# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ee73f7acd32494fb5f309234f4695b8ccd6cb5369c0ec049bdcbbb7b49e4afdf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7bc9160df47315484b2355a2946ffc828476ab747ee4ed49520dc031cdc1eda4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cb36c245f65538dd202266393267f83a3741433d7f9c381900e40124a196d147"
    sha256 cellar: :any_skip_relocation, ventura:       "72f36a833500fcddadc8d44a4888c400987273e909172e649485b44bc008a727"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "133bf45c270c316d9e3f8d4b57eecdecadf6ef24ecc18955b27d63ac7810ff8e"
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
