# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.2.tgz"
  sha256 "c85b6739e4e6b0816c4f9b4e6f7328d614d63b4f553641732b918df54fe13409"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a8606b9673837f71b97081c0167ce916c513d15e247b8feef93cea9c56d75846"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e0261357aa77502530f41881bb68711ab67bb6d8dd28547ddb7c33abf1437151"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b587a3792f84448de2751c12547b167883f3541fbebe3ed70330f84faa4ed042"
    sha256 cellar: :any_skip_relocation, ventura:       "b94b8339ee7e7f15e2f7bd1d3bfcf41e35b950f80aa0f1a025174e3761f42f06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b20e5c47b68dfcff6b72970bc18acc5fbf689255e29a8b3775543c827e942f43"
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
