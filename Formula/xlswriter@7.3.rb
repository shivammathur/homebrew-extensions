# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6ffa97a94802d68135026be65d55c16d3d0d74a85fa513e791b48d4ebea009c3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6be0922f4047ad5e0347bd67fab2b6fd8597dcec5c06b3355ab1a0f64acbe6fd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bd059749d347bf0bd3d4dbb251bb6ae46a299c24c6b909b574742cd1df0750aa"
    sha256 cellar: :any_skip_relocation, sonoma:        "575d9399cd92de2bd5a93b5355879185e4da21f5e92a6579d3a95b25b0fdb343"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4c6156a192b3a985fa03db4b384b8ec5308f2d82e7ee0f43360ad7b69a349ee0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d189bccc0e539cabb6418f3207d34dad59f1beaca838eb253e1aeb350da0e3b9"
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
