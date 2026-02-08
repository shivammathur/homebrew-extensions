# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "35a78d108122c2e5979a9d87a64e901c9b2b978f4053da7663467c0c3aef144e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8c77419c3e128c219f678a08860b80745bf6021748c0f910f61463d7a5399298"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1b2f5fc8424413e1f831165ff584ebdba3cc84eaf26a2f6a106ed38874daea43"
    sha256 cellar: :any_skip_relocation, sonoma:        "76d8d1902b9100b543fa4aa57c31faab0eff67ce8bda503c292fc8939cf2f980"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "355aad9945a28e4fcc4a83427fcb85c7b7acb64034a75defbbb8233bea19019d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43f57faf34fbf2b91bbb1184ad69a9b6721b1558833215b0706e2945d976b02f"
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
