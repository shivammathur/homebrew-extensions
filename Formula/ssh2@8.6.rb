# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "3200f0caff00885ddadca791a07b7f25af472123c3be53f00ca648e6d4e1e79c"
    sha256 cellar: :any,                 arm64_sequoia: "66d6bcbae8c94fe5940412cd83dee2c4a2b4378b4684028998e38afc6e184839"
    sha256 cellar: :any,                 arm64_sonoma:  "2037d1d2c24ece434320b41729e246e196dfd3afb54bb22c20516bc792d7a835"
    sha256 cellar: :any,                 sonoma:        "15a1b77aaa37ac38f47c2f4dd59839da7865af8c37a753657e39e9f742fe265b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8c9406d4f693ff9d44c0f1235f13294611f9191556abee7d7bc91693834ebc53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21330f8baf9469ca21b96333fc7370639354ac48badf9f31926defcb2fb5f253"
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
