# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT81 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.8.0.tgz"
  sha256 "19abac84376399017590e11c08297e6784e332ec7eb26665a55f8818333d73c0"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4057dac28bcc9f08a54b542fde70f97ce28023f4419052a373ab7dddc74be6a1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "66766cff878c80cdce842aa186a480c00c256c2efc946afb30effee9e29b8ff0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3741ca8637495822cf42070c1e52994cefbb052a6b25fabf9389d89638ea0177"
    sha256 cellar: :any_skip_relocation, sonoma:        "cf834e4b27866ff654c42a0b56dee59e6c31be0ec7da853843f923b94705dadc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e6ca4578c69f495257e9bc3be9ef1ea06c15c0470436bd40fc6b5dac1c96f7a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4de75e394dc112e98da5247ab570a6652d6380495bc63138177fb7f532a36290"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
