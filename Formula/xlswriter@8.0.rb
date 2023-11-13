# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5c9537dc22235eac7e45de57ddfbe441a9d05d69d9111601bc7f2eff0845dd33"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ceacb3c4599af6ce4a5acea92a8a0ed8e8a3eb1ece1660211cefd7837e083e1a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f9c0b2271863340e05f33554fa1c0d8bbed278843c25e69c9442c67d3720e7f9"
    sha256 cellar: :any_skip_relocation, ventura:        "7c43d433d7e4053e94e470d136017db48e7db605d158f83b5b6918af94231805"
    sha256 cellar: :any_skip_relocation, monterey:       "deb97cf39f9c67dbdf2e301c0f1b44442ef3e9baef91c8950377345f00108e34"
    sha256 cellar: :any_skip_relocation, big_sur:        "0454382a6fc6e947d1f395262cc0ff5e43f276b5ebdb4baeaf6d2ba3c2738496"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7eca50e0b6900201670026f03f507053b55d89eefe47220d6a32bbe2650ebf98"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
