# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.14.0.tgz"
  sha256 "9160c586227f3ae64a282eae5eec4241107087ca66689ac44498fbcd2b3f3c52"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aace5d79a1bc78aa4969aa17d83f39fa61f8fa6e9b837bc6690006f031a2a8d7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "86fe2bc7cab9455d0d2c76d6a3d210bec49e9d3fea2c5f07bf8db5dfc88b6169"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5fb8cc3d7802eb5949009b7c8fef6e856f74a61bcf37257c26a3aa61d58642e5"
    sha256 cellar: :any_skip_relocation, sonoma:        "b3d5582dfa4a26d45b5dabcabaa633cd0a0fca58ea40995f681e027f4c1a94cd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0bd4d81b393b48199c4565e764e106da1b363adc6be94a4761ab61d6f7dea7c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce080cf2489458b9e39a40b56e70f8d3824c71eb8ab55822f7c871a29ef6e954"
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
