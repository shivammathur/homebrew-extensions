# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8793825438dc539bbc15f39369cab4f01318431b.tar.gz"
  sha256 "6cef4d23af57c595f642e7e00eef87a8f805845c108e0ea851c4bcb1ea698ec2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "ca5fa7d7bd782d3328c8417dfd01c55193c89aba736a3f3c9ce75ff0833fef68"
    sha256 arm64_sonoma:  "3a132c097124c7b9d5d407d58aae8ea63fd480fa7d441b794ceff4e3322b1679"
    sha256 arm64_ventura: "d302498520824e042e82b461483184c3c46a1799b4ee0bd1d39214f47098dcb0"
    sha256 ventura:       "bfcf78556541e9d33fd8b80fe7918e7110ac67efb8b7fbeccdea072a02b34ed5"
    sha256 x86_64_linux:  "244fd3a458d4465618bd62156dee08ffe813afe7ca83bb7628e775151a1aab10"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
