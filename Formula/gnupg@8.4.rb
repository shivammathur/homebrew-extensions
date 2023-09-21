# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "bc90f911ff8fa6a7d1a89c10f1a96588aaca34f056ab7a5c6084d8f60ed0fc87"
    sha256 cellar: :any,                 arm64_monterey: "491c4641cdb29036d33a53c01a3e7df85b88383b7019d022f6744e8b19b46dfc"
    sha256 cellar: :any,                 arm64_big_sur:  "fa6127fd425caf3dcbac81d265a34e2f2136a7b65715ec27b5036ecc213a2002"
    sha256 cellar: :any,                 ventura:        "bf7d9d874465cb0fa6f4aca5f033b895e52719003b25b31afc2efba3b179d556"
    sha256 cellar: :any,                 monterey:       "ed16e613f9eb36362bb1867c840e5143a7875a2dbbbdcecc8ea50185ab1919ba"
    sha256 cellar: :any,                 big_sur:        "d402557086852538b561b031dac032606416ccb94f4fee0acbacd265e9ea36dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c200b53071d3d604b3ffefdbd72debba985a1015785de24793e9e99b8014e7fb"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
