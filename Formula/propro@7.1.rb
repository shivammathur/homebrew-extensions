# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dd5def259dfd469478ae9797eb5d2abf89d7e4487d07ecaf5cf2393d7393a14e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d8ab16b166e6ede48778926de7ebe65391ebc3b94544c067f21ff1a9d3ea5946"
    sha256 cellar: :any_skip_relocation, monterey:       "0062a30ff8ea1600df5d6cc2b26deb1e809550030b608d5d77fb9a04e10a7d0a"
    sha256 cellar: :any_skip_relocation, big_sur:        "8be7a46b60f5b73402655bda7f60d37c2a3eca2e0d17cc437e0a9e45262ddf0b"
    sha256 cellar: :any_skip_relocation, catalina:       "e34e388bf2d462c23a2e06e9f95a75ab91ad626d1cbeaaa0e2cf30b392cf6724"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "07088dabe94428d172fb25d7587ac390cf0790b9bb02528fce79dacfedaf2761"
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
