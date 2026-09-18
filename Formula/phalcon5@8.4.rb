# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.21.0.tgz"
  sha256 "e7e81858b2dc11f578a3a8c4924b37d86bec67945bcca725bc34a51ba50c43f0"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a12e7eed67689fd04376117fa0a98b802b28d2859d33921332a51278b6a32827"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9de241c6f29e6ef2968fd1513cced7fa26f85d6db82b92f73ae7bdddec51f25a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c8ed5fcb5bd5269ae5301124ac853bfca044332775de4e9d194f46c84ee3054d"
    sha256 cellar: :any,                 arm64_linux:       "d310cd9ce652bfd16f92c32af0dcca0bcb0fad8294726149ca66e91fbd22220d"
    sha256 cellar: :any,                 x86_64_linux:      "aa83561e79d432dcc1da1845e7c51a05173cfaf737cf7b6a666566d6746ca1f8"
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
