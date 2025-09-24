# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8261b3596cd8cf18bd4e8eae80b443f5707c86231e7da20c52fb33f9a731559d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5684c79520b92c24075a676649054a7f9e0ca57c6924087c32ac32eb0581e762"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ba67df48dd3759baf4dd307055386565dbc96793037eb427b6d258196aff0b24"
    sha256 cellar: :any_skip_relocation, ventura:       "43641dbad2313e12a02e696859c80d5bfa97e29c14959a54859cbc091177ad8c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "79a958fe21c1ee4a7e15c0f66bfbfbf98d83adcec99468d7402ec77456b32675"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6daf79a9004655dfe66fae7ee412718d7d21d54a9c1b041fdbe9b07e18ce813f"
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
