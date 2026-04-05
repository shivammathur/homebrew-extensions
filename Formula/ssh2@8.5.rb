# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT85 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "49ef3e044ade8a26c389ee07819ebe19e0406d2722ced05487c6f5f622238208"
    sha256 cellar: :any,                 arm64_sequoia: "d117030737c97364ea01b731bc0c43141f92632398700213dca250a4d8cf1a97"
    sha256 cellar: :any,                 arm64_sonoma:  "806d42eae9b9403b984a2e949f82af738ba049de35cd387e03a3430839c6c026"
    sha256 cellar: :any,                 sonoma:        "79cf4fd3a03cf87ab86a33a71d72a3a0d3e391ccfbeecbfb6db9c6720d58a658"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1b385dd5f69f2635ea56e7621fd444e9e36b842f599936c2067435f6563882a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc1186e6d02b1564e9b8a19982d0464010026c76462310eb2daed60751e13f45"
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
