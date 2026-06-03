# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "514f98ff081477b4d84623aaab3c80c65f5e836160a7023f135f135625fb7d3e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "004a3d76ebc752e05f709e3c4dd82844fcb03a58ffe5cedb6581c03173786c90"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3bf4abc24bb40c7ac3966e652ce08515078695e627cd579cdab9572094073cfb"
    sha256 cellar: :any_skip_relocation, sonoma:        "0e944225489ee1e7ce97143cc1115d6a5ce8666ec510ced2f81bdcd09df65fca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "81d15812a76d6991d30d9e9f03ff1b19c42e3556b5e1c0e9133f36a68e577d04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e855cfa6f3b65f07471159aa34fcdbf63e3f495ff71aab6467d2c7235b6fb07"
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
