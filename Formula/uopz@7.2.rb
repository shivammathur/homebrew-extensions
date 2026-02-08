# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT72 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-6.1.2.tgz"
  sha256 "d84b8a2ed89afc174be2dd2771410029deaf5796a2473162f94681885a4d39a8"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1a28ccd3469967151b40cbc6c5e67b638ae251315717b4a2e37e0eb66e073ade"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c667edbc05af2c39aeda66835c4f55cca349d0eae770f7ebd1a4bdd3cf2318f9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8fd13d7dfcf62f247ac35156717d6d72343f3ddf096bf324b260e09d54fd547a"
    sha256 cellar: :any_skip_relocation, sonoma:        "f12e765826ec01a903307a84b3d1b77d2a5d64847f260d436e5ce1e539305c8b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e44b43878cd793cee8cc2d76575bc83d031bd66acf21dec6ba85210c6cc20998"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7dfcf15f78ecaa17ef9973a034cee53919300b2ec1414b58ceae0452e906975c"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
