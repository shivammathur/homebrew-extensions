# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.2.tgz"
  sha256 "c85b6739e4e6b0816c4f9b4e6f7328d614d63b4f553641732b918df54fe13409"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d7362153fc66ec71175c3bc42c402cbd752d00000dd05fb802f568d62474db73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2111b8b8022eabdf226a1262adc49b8ea3085a62efff3b23f871781aa3f3c35a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7486ae80f04b4823d44f005a3bef36e67675a12f72a859bc4c05aee45983468a"
    sha256 cellar: :any_skip_relocation, ventura:       "074d3081ca5ac5214f13cdaa4c43cfcedd9d038a365d45cde759a886a378f18e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2687cbef504673cb4c80f44f41fd53a6dca8b3f88b92668d1883b29fd3161fe9"
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
