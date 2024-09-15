# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "31a23e4fda1e7d860ec82398fe8a408c030bf3cfece3de3499fede5cf5218d42"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1c232a7860770ef07fa35acc83fbc25b08a0e26b6878547910970ab0745bc7ef"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e936da230b93a363ce33e053565769ad226761dd90652c79bd1a611cabc07f37"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "33525ff34c8ed3cef8e2d52c1b50de64453502d6cc37edee0e8570eb17be4af9"
    sha256 cellar: :any_skip_relocation, ventura:        "14c632b0c7de5e6815854c1a6f75b1be1e7faafab32ceb7487871b3cf82aa2bc"
    sha256 cellar: :any_skip_relocation, monterey:       "7fff95ecc102895989792e9e8ed97530d91f097ea490911eaab04349f3de40cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc4d12058160f10df9f70c2b2f89f8438cfa5d4c2cc5bde97fa3a44fae579398"
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
