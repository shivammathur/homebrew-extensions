# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e255c35672d97c9b6d69c00a02113edd9ffc37c97b85bc3f44f4495b89d93e64"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dfb82f8ac216abebf5c5fcee086733a4f42020f10f06ea0c59323a9a6c32ce48"
    sha256 cellar: :any_skip_relocation, monterey:       "10914550bc6d05a66da7f310e5119b5a3b865fdc92af964907797eeff84e0dec"
    sha256 cellar: :any_skip_relocation, big_sur:        "a002c94cc25efb526710a0194a862233aaca01f745824aa205483baa6962c3db"
    sha256 cellar: :any_skip_relocation, catalina:       "48b8249c2807409048e77ed602f8a46cfad902929c3acc82070948e86a1ac566"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7e9cfb57c89dd572cd17df4be73ec933f4605b8411b3dc06463c0a001ce11c47"
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
