# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6cefa93b113aa8f4d7ef57b42b6a2eb8dd4f57afa4073df8ae3fd8649c76ee5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6b1cce447a2a63244a2ae3d930c12b0ba1d3f6ea9a61f885c32789fb05402613"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0d71ca0833f95173789c642f684ed1ab9e593161391dad6b48569c159001e46a"
    sha256 cellar: :any_skip_relocation, ventura:       "9c09ca49f633354dcfbb23ce7097165bd0613ccd66e71989edd4d71e5d412e8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "009fd49c4ee359a6d4463a3eae75f17451351aed3911897deaea85d9ae0d9b5e"
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
