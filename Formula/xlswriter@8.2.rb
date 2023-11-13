# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a65c871183b3c3c94680ee90095c8a6569930b4dff16db7120638136f4044884"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8eeb403b6a0ea04a9dbaeb0689416c388d55deacf7df47daf3a107927d8edff8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8e56839a6620d9e3943c1245033c00d2841df344c20a2a83ec92262e2626c610"
    sha256 cellar: :any_skip_relocation, ventura:        "efe1833439f3ccab307849dba8d910778439dadd7bbf6c2f83408ade940e5a07"
    sha256 cellar: :any_skip_relocation, monterey:       "ccc3cd39ca24652ce6c4ac2d7c981e3baa39416e2eb05071a361e405304f158f"
    sha256 cellar: :any_skip_relocation, big_sur:        "4ac6503f8eef2bd9548b3b82bab436e8c6241d9696bb7abe93fdf0f2db564761"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fded1024416add7111b2755082b8c1d401a4c6a8fe131c1887ae731c30453df4"
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
