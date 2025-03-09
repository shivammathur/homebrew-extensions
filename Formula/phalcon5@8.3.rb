# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.0.tgz"
  sha256 "7b8622bf7df5385e159dde3f41ed91bc6798726d8d725a46db8ba884651664d0"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9c7e20dbdae7fcf6eceef436ab2bc51e08b3be8871d130167235b6c7d6feaa67"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "26cd9a2391e2d349c47b0884d5fd2d7a25f14eea73b083f423bf354b73828a5e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1e66078c873accdb6a4f40607172882f46b556e709145a47a16c5005b07eaf7a"
    sha256 cellar: :any_skip_relocation, ventura:       "450685ad539fa1de1e33ba834d345f4ff0db715a7812fe88428f1b378aff24fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91597135afc61010077b1691573d7ce44c9b4887cc94d0c245605a9ff38c64e6"
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
