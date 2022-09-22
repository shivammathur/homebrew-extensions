# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dc3f3d878bdf3195f819cc187ef948c33baa4815b397fd9189390e0f4069738e"
    sha256 cellar: :any_skip_relocation, big_sur:       "ea6e77aa28d8a95fe378ebda65ed70776286693c60b46e62ab790e91cb768403"
    sha256 cellar: :any_skip_relocation, catalina:      "c2ef3472a6488c2ea3b1d108059ffcf1ce5f1fa660264efbfa097673a79666b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "61dee77d50cb91471179de76342b10d2e11b6571c20bb5e9dd9fe46a461ce883"
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
