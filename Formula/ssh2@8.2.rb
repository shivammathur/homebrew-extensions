# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT82 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "7adfa2fa46bec08b19586a54848d3df76617bf0f653f025efedd3d2470e2cbeb"
    sha256 cellar: :any,                 arm64_sonoma:   "87949b802ec036bcf8b7cb7a6645d5511845529247a80f423f98a1df3446d56f"
    sha256 cellar: :any,                 arm64_ventura:  "5e21e8a5c71e357c1fd2006554c23de2213c9b07d4649166fc0f6ce7ab991ea9"
    sha256 cellar: :any,                 arm64_monterey: "628302ad2fe0f10f4b9b79792733c82a90d13152a840e603a779c547917dfe12"
    sha256 cellar: :any,                 ventura:        "a7c6064b10387e1c260a988369cfb194ee4e3ac13c5e5502ca2b54b859337534"
    sha256 cellar: :any,                 monterey:       "30e21f8b76e2ee7ea38da4e017f9762a10b9025a18fd543a083d9f838f92ad51"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "edb59d13248b86206608ca2bcaf978f08635f913ecbd09c76f020086d5ebe659"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d769b7f94a0ed6c8b553a0392fc47a24efea48cc54b9f71a818f330620ccf045"
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
