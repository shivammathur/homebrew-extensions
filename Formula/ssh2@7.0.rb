# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT70 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "6c887238a4001167b92ab5df1de0de794460593da3db868b1b46fdc50c421d27"
    sha256 cellar: :any,                 arm64_sonoma:   "d141496954a7359b973191900388aee99729774f843db4f5f21f0e6b426eb94e"
    sha256 cellar: :any,                 arm64_ventura:  "65d9d34e1e50975fa32b916bec64c36f81b0711ba850f0585cf666c2fd8af858"
    sha256 cellar: :any,                 arm64_monterey: "2b13b3e6add6a94b374a57b92a3f9e5b1c0ec3b7891c19cfc5c6c6218948dd34"
    sha256 cellar: :any,                 ventura:        "29a1947639188d1b47ad816fe44a0ea417e303e6b5a2f65936866ae5d4ff0f3c"
    sha256 cellar: :any,                 monterey:       "2e30fee65586d286bf40e430d65378dec04819a8252561a83c1de3d5c14e98c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "32c63885a52d0ac777a78b1ebdbc5cca2d6f729a4b78c238c87a7313c9454019"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
