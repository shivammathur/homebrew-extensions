# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.17.0.tgz"
  sha256 "21bfc8a96bb8f9683ff64c81179d1a119b188df8eb0391db43948011a2229f90"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "04901d7b646eddf6d86702b2f1dfe595d1d94ca27524f566ce921fd2237d9f16"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "739a12ecb0fadd7355455117e254d149a5f03fd89665088b1bd30f210ab58f56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e41e2af9e1abf36bd9edd80ad1a501c8501c5b3b8cb0a2e20d778ac770bca2a"
    sha256 cellar: :any_skip_relocation, sonoma:        "3f7b47f4949f554f4ebd7231cdc3ff6ff5549b1723c009742c444293ba562778"
    sha256 cellar: :any,                 arm64_linux:   "306ebfba5c3429cc832ec824e726b4c966b78e35e3976803afb2a0c3f34cb1d1"
    sha256 cellar: :any,                 x86_64_linux:  "bd9ce54dddb984ba60c4e02d8fb5661fee63197a292feda998d43aac0c9eac0a"
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
