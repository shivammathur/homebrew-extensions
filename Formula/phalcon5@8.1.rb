# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.5.tgz"
  sha256 "860e4fa67073a551c67b412ff0108306f01c5512b1e6c2192128c7ef02a3c83d"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b4fadcecdee90dec0a44775a73cdf1e2fb7fb69dc229716e501e55a4651fbd8a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3e1c9075c25d60bab731695768f89f3b753af7cf2286dd2ff904325667390c42"
    sha256 cellar: :any_skip_relocation, monterey:       "be647dfa2ddd9395b31d664b0083c39d4cba6b4953b94074193358070ab8c57f"
    sha256 cellar: :any_skip_relocation, big_sur:        "4ad79bfb22fb80010de2121449ab8ccb18eed72c2835949650612e2d470376be"
    sha256 cellar: :any_skip_relocation, catalina:       "5ffd64affaa9644c4b04a59347db3715188a10c092c3f89d1ede5c9bcde50f7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2f0dfd9fd9c29c136dfd8846f717ed0ede580b28c58dbdc4c0630c680a9e19ba"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
