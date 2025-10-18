# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "693d6dfe60f901fd0dc04f138164e70c80e7518ccad408f24f313daa7c9a5c5b"
    sha256 cellar: :any,                 arm64_sonoma:   "238b25bdbd8e70720f52bf93b61ab94f2d3454c070de18eaee013c8fda5b1005"
    sha256 cellar: :any,                 arm64_ventura:  "a47c6aaafbf8a062d3eb561a57a32b46016953d96ca8d0c49dea3cec33bf713a"
    sha256 cellar: :any,                 arm64_monterey: "9922c76011a790f7705c1c1dd6f3db7099c1e1594d4850cd7ff11cacbd0a92a6"
    sha256 cellar: :any,                 ventura:        "21b3afdbfc5eb1d7be2d6ab53299e47f597f61494fdfcc44375b5bb7d1c13080"
    sha256 cellar: :any,                 monterey:       "fc9f83062e526e79eff29fe6fc4d9cb2aff26236d4a3cc370f264d4ab61582cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "d8591cde92ea336b1f5d55f32e1e9d70a176e02659b47903f87fde5e8734bba1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca24fcc534a083dad8f7b19b9110ec11175bb9058607b2795c7094a15425f7e0"
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
