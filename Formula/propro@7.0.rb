# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT70 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3a00a8fb09f2786ad9b24f2fa36c21f85944443a805ea34567684ff0e11f802a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "28a82a5fc4076a4336d967bcd79702ddb8a7de2c0ec3085cdb9a698a298c3265"
    sha256 cellar: :any_skip_relocation, monterey:       "9d17829330536073b919bd86cb348be797c7013fee1700b550b4a26ca6dca646"
    sha256 cellar: :any_skip_relocation, big_sur:        "2aaafb228ac3cc1b337aca8ffba09b749dd97dc7320480cf03924b4c02fa2b15"
    sha256 cellar: :any_skip_relocation, catalina:       "f97119f306a82a2248de85589a84f6f7dc717bea402eaebe9afbc70403648dfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39367bd3014329f6a2aa93089cea0c02a7f6dea08285fc343022ae4eaac0ae93"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
