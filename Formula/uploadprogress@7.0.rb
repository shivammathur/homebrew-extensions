# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT70 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.1.4.tgz"
  sha256 "9ba0f010f78889b8d69c5c643a9c920d1e140cd1d06817b8bf4ee76f996138c0"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0b3bdfe760ae9331092dfee4ccae37181ed1ce80c6f16842db3ccb61cc832f2a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7e5197badce9ba6b2e8cc01d43d8ded7371a587ee85cd30d5f516d6b3a668c8a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8bf68073b7b3fffff56377b4ce932693f85e124b9ff46a076ca2213ba745ce93"
    sha256 cellar: :any_skip_relocation, sonoma:        "9fd06d9d4342745d4bcd5c0bf496459fed328ac0a3f67de40eed6c9c5c38acc2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8ad8644ad146d5c0afd5839d7f5ac283bc4aca032e859dd0b463d72089a6e504"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2a76e682819f3c8962dbf2e844d28b07d60c911aec7b4e9b9df3c3c5ae5f705"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
