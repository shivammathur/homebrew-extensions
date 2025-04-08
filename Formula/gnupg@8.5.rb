# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT85 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.2.tgz"
  sha256 "ad57aa23b3aef550fa4deddd003ff5322b886d55a67d1b020f5682ab829809fd"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a594d3d265b92425390a9b4c70c3c7cec737d3b279d17f7319c90bed2f641ad3"
    sha256 cellar: :any,                 arm64_sonoma:  "fee0ceb1fd04a3b8fbaa29e8170e3685f71e3920cd46a05c6a98f843c1f5eae5"
    sha256 cellar: :any,                 arm64_ventura: "270fc96b6fc603891062462a9b6aa3cfb2217053d1681a88e2cd8df4b7a74d31"
    sha256 cellar: :any,                 ventura:       "b62ddc5a93268b3b26a1007e6f1deb291f83928513240de96e6190e3dd81c29c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "765ec5f194aad9fff920f522be545d54b9cccee8ad3ac9c707cc8bfc5f5e43a1"
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
