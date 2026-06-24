# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.16.0.tgz"
  sha256 "33db2df75a81224f710a2435f7f81c5fe1486ea1fb11579f66c4875a28b4d607"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0ddb4483cbc4e05c389ed55cd346d45d7f91db52ff8af961ef3eb2b63ee4367a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "95c4f8a59885028f2b08ddbe4cf342d31cd901884374b9f1ab3318cd97b95576"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "db7a46ed55e85d0f23ec493210286ddee076964627c1d374b3573d3b97ef6fda"
    sha256 cellar: :any_skip_relocation, sonoma:        "03c15401087484a8be1f29381431ca6fe3355382e9d2d9e40a6086b1ebd18db4"
    sha256 cellar: :any,                 arm64_linux:   "1f97d0d4a009504d76b56799c7dbb21b47bc8b1b762e226d0db9f65f94834045"
    sha256 cellar: :any,                 x86_64_linux:  "26568c33dc96cc744e4856bb181ac9bba280e8190c8b840a79dde602b24bbb3b"
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
